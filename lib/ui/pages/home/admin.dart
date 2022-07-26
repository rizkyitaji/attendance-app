import 'package:attendance/models/user.dart';
import 'package:attendance/providers/user_provider.dart';
import 'package:attendance/router/constants.dart';
import 'package:attendance/services/themes.dart';
import 'package:attendance/services/utils.dart';
import 'package:attendance/ui/widgets/container_shadow.dart';
import 'package:attendance/ui/widgets/custom_appbar.dart';
import 'package:attendance/ui/widgets/empty.dart';
import 'package:attendance/ui/widgets/loading_dialog.dart';
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
        return (e.name ?? '').toLowerCase().contains(value.toLowerCase()) ||
            (e.nign ?? '').contains(value);
      }).toList();
    } else {
      _users = users;
    }
    setState(() {});
  }

  void _showDialogConfirm(User user) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.all(16),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Apakah Anda yakin ingin menghapus data ${user.name} ?',
              style: poppinsBlackw400.copyWith(fontSize: 14),
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _delete(user.id),
                    child: Text('Ya'),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      primary: red,
                      side: BorderSide(color: red),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text('Tidak'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _delete(String? id) async {
    final prov = Provider.of<UserProvider>(context, listen: false);
    showLoadingDialog(context);
    try {
      final result = await prov.delete(id);
      if (!mounted) return;
      Navigator.pop(context);
      if (result.value!) {
        showSnackBar(context, result.message!);
        _getData();
      }
    } catch (e) {
      if (!mounted) return;
      Navigator.pop(context);
      showSnackBar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Daftar Dosen',
        showLogout: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
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
                      hintText: 'Cari Dosen',
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
                    Navigator.pushNamed(
                      context,
                      profileRoute,
                      arguments: User(),
                    ).then((_) => _getData());
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
              child: RefreshView(
                onRefresh: _getData,
                onLoadMore: _loadingMore,
                child: Visibility(
                  visible: !_loading,
                  replacement: Padding(
                    padding: EdgeInsets.only(top: 200),
                    child: CircularProgressIndicator(),
                  ),
                  child: Visibility(
                    visible: _users.isNotEmpty,
                    replacement: Padding(
                      padding: EdgeInsets.only(top: 55),
                      child: EmptyWidget(action: _getData),
                    ),
                    child: ListView.separated(
                      controller: _cScroll,
                      itemCount: _users.length,
                      padding: EdgeInsets.only(bottom: 80),
                      itemBuilder: (context, index) {
                        final data = _users[index];

                        return ContainerShadow(
                          onTap: () async {
                            _searchFocus.unfocus();
                            await Navigator.pushNamed(
                              context,
                              attendanceRoute,
                              arguments: data,
                            ).then((_) => _getData());
                          },
                          padding: EdgeInsets.all(12),
                          margin: EdgeInsets.symmetric(horizontal: 2),
                          child: Row(
                            children: [
                              Icon(
                                Icons.account_circle,
                                color: Colors.black.withOpacity(0.7),
                                size: 45,
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      (data.name ?? '-').capitalize(),
                                      style: poppinsBlackw600.copyWith(
                                          fontSize: 14),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      data.nign ?? '-',
                                      style: poppinsBlackw600.copyWith(
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 12),
                              InkWell(
                                onTap: () => _showDialogConfirm(data),
                                child: Icon(Icons.delete),
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
