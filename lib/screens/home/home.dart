import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_clone/cubit/post/post_cubit.dart';
import 'package:tik_clone/repository/post/post_repository.dart';

import 'package:tik_clone/screens/home/tik_player.dart';
import 'package:tik_clone/screens/home/wrapper.dart';


///This is the first screen to show, here is the list of videos to show

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  Widget body = Container();
  late PostCubit _cubit;
  bool alreadyLoaded = false;
  int _selectedIndexTikTok = 0;
  PageController? _pageController;

  @override
  void initState() {
    setState(() {
      //body = _getBody();
    });
    super.initState();
  }

  /// build the main content

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocProvider(
        create: (context) => PostCubit(PostRepository()),
        child: Builder(builder: (context) {
          _cubit = context.read<PostCubit>();
          _cubit.getInitial();
          return BlocConsumer<PostCubit, PostState>(
            listener: (context, state) {
              
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _getBody(state),
                  Container(
                    height: 50,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: buttons(),
                    ),
                  )
                ],
              );
            },
          );
        }),
      ),
    );
  }

  /// Here i build the tab content

  Widget _getBody(state) {
    _pageController = PageController(initialPage: _selectedIndexTikTok);
    switch (_selectedIndex) {
      case 0:
        {
          if (state is PostInitial) {
            return loading();
          } else if (state is PostLoading) {
            return loading();
          } else if (state is PostLoaded) {
            alreadyLoaded = true;
            List<TikPlayerScreen> tikToks = [];
            state.posts.forEach((key, value) {
              tikToks.add(
                TikPlayerScreen(post: value),
              );
            });
            return Expanded(
              child: PageView(
                controller: _pageController,
                  onPageChanged: (index) {
                    if(alreadyLoaded){
                      _selectedIndexTikTok = index;
                    }
                    if (index == tikToks.length - 1) {
                      _cubit.addMore();
                    }
                  },
                  scrollDirection: Axis.vertical,
                  children: tikToks),
            );
          } else if (state is PostError) {
            return error(state.error);
          }
          return error(null);
        }
      case 1:
        {
          return Expanded(
            child: Center(
              child: Text(
                "Proximamente",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }
      case 2:
        {
          return Expanded(
            child: Center(
              child: Text(
                "Proximamente",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }
      case 3:
        {
          return Expanded(
            child: WrapperScreen(
              onTap: (){},
              upload: false,
            ),
          );
        }
      case 4:
        {
          return Expanded(
            child: WrapperScreen(
              onTap: (){_onItemTapped(0);},
              upload: true,
            ),
          );
        }
      default:
        {
          return Center(
            child: Text("404"),
          );
        }
    }
  }

  /// Just a loading widget

  Widget loading() {
    return Expanded(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  /// In case there's an error

  Widget error(String? error) {
    return Expanded(
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.error,
              size: 70,
              color: Colors.red,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Icon(Icons.replay_outlined),
            ),
            error != null
                ? Text(
                    error,
                    style: TextStyle(color: Colors.white),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  /// Here i build the list of buttons for the navbar
  /// this is a custom "navbar" cause it made things easier
  List<Widget> buttons() {
    List<Widget> returnList = [
      //HomeButton
      Expanded(
        child: Column(
          children: [
            TextButton(
              style: TextButton.styleFrom(primary: Colors.white),
              child: Icon(
                _selectedIndex == 0 ? Icons.home_rounded : Icons.home_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                _onItemTapped(0);
              },
            ),
          ],
        ),
      ),
      //HotButton
      Expanded(
        child: TextButton(
          style: TextButton.styleFrom(primary: Colors.white),
          child: Icon(
            _selectedIndex == 1 ? Icons.explore : Icons.explore_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            _onItemTapped(1);
          },
        ),
      ),
      //AddButton
      Expanded(
        child: TextButton(
          style: TextButton.styleFrom(primary: Colors.white),
          child: Image.asset("lib/assets/img/add.png"),
          onPressed: () {
            _onItemTapped(4);
          },
        ),
      ),
      //MailButton
      Expanded(
        child: TextButton(
          style: TextButton.styleFrom(primary: Colors.white),
          child: Icon(
            _selectedIndex == 2 ? Icons.mail : Icons.mail_outline,
            color: Colors.white,
          ),
          onPressed: () {
            _onItemTapped(2);
          },
        ),
      ),
      //ProfileButton
      Expanded(
        child: TextButton(
          style: TextButton.styleFrom(primary: Colors.white),
          child: Icon(
            _selectedIndex == 3 ? Icons.person : Icons.person_outline,
            color: Colors.white,
          ),
          onPressed: () {
            _onItemTapped(3);
          },
        ),
      ),
    ];

    return returnList;
  }


  ///Changes the index of the navbar.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
