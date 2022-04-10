import 'package:attendance/models/user.dart';
import 'package:attendance/providers/user_provider.dart';
import 'package:attendance/router/constants.dart';
import 'package:attendance/services/themes.dart';
import 'package:attendance/services/utils.dart';
import 'package:attendance/ui/widgets/container_shadow.dart';
import 'package:attendance/ui/widgets/custom_appbar.dart';
import 'package:attendance/ui/widgets/empty.dart';
import 'package:attendance/ui/widgets/refresh_view.dart';
import 'package:attendance/ui/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminHomePage extends StatefulWidget {
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  bool _loading = false, _loadingMore = false;
  final _cSearch = TextEditingController();
  final _cScroll = ScrollController();
  final _searchFocus = FocusNode();
  List<User> _users = [];
  int _limit = 10;

  @override
  void initState() {
    super.initState();
    _cScroll.addListener(_scrollListener);
    _getData();
  }

  @override
  void dispose() {
    _cSearch.dispose();
    _searchFocus.dispose();
    _cScroll.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (_cScroll.offset >= _cScroll.position.maxScrollExtent &&
        !_cScroll.position.outOfRange) {
      _getData(true);
    }
  }

  Future<void> _getData([bool refresh = false]) async {
    final prov = Provider.of<UserProvider>(context, listen: false);
    setState(() {
      if (refresh) {
        _loadingMore = true;
        _limit += 10;
      } else {
        _loading = true;
        _limit = 10;
      }
    });
    try {
      await Future.delayed(Duration(milliseconds: 500)).then((_) async {
        await prov.getUsers(_limit);
      });
      if (!mounted) return;
      _users = prov.users ?? [];
    } catch (e) {
      if (!mounted) return;
      showSnackBar(context, e.toString());
    }
    setState(() {
      if (refresh)
        _loadingMore = false;
      else
        _loading = false;
    });
  }

  void _onSearch(String value) async {
    final prov = Provider.of<UserProvider>(context, listen: false);
    final users = prov.users ?? [];
    if (value.isNotEmpty) {
      _users = users.where((e) {
        return e.name!.toLowerCase().contains(value.toLowerCase()) ||
            e.id!.contains(value);
      }).toList();
    } else {
      _users = users;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Daftar Guru',
        showLogout: true,
      ),
      body: RefreshView(
        onRefresh: _getData,
        onLoadMore: _loadingMore,
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _cSearch,
                      focusNode: _searchFocus,
                      style: poppinsBlackw400.copyWith(fontSize: 14),
                      onChanged: _onSearch,
                      decoration: InputDecoration(
                        hintText: 'Cari Guru',
                        suffixIcon: Icon(
                          Icons.search,
                          color: blue,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 24),
                  InkWell(
                    onTap: () {
                      _searchFocus.unfocus();
                      Navigator.pushNamed(context, profileRoute);
                    },
                    child: Icon(
                      Icons.add_circle,
                      color: blue,
                      size: 48,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Expanded(
                child: Visibility(
                  visible: !_loading,
                  replacement: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 200),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  child: Visibility(
                    visible: _users.isNotEmpty,
                    replacement: Padding(
                      padding: EdgeInsets.only(top: 120),
                      child: EmptyWidget(action: _getData),
                    ),
                    child: ListView.separated(
                      controller: _cScroll,
                      itemCount: _users.length,
                      padding: EdgeInsets.only(bottom: 60),
                      itemBuilder: (context, index) {
                        final data = _users[index];

                        return ContainerShadow(
                          onTap: () {
                            _searchFocus.unfocus();
                            Navigator.pushNamed(context, attendanceRoute,
                                arguments: data);
                          },
                          padding: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (data.name ?? '-').capitalize(),
                                style: poppinsBlackw600.copyWith(fontSize: 16),
                              ),
                              SizedBox(height: 4),
                              Text(
                                data.id ?? '-',
                                style: poppinsBlackw600.copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 8);
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
