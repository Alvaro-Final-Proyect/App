import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:padel/screens/home_screen/home_controller.dart';
import 'package:padel/widgets/custom_drawer.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final homeController = Get.put(HomeController());

  Future<void> _logout() async {
    await homeController.logout();
    Get.offAllNamed('/login');
  }

  _loadUser() async {
    await homeController.loadUser();
  }

  @override
  Widget build(BuildContext context) {
    _loadUser();

    return Scaffold(
      drawer: Obx(() => homeController.isLoading()
          ? const CircularProgressIndicator()
          : CustomDrawer()),
      appBar: AppBar(
        title: Text('homeTitle'.tr),
        centerTitle: true,
        actions: [
          IconButton(onPressed: _logout, icon: const Icon(Icons.logout))
        ],
      ),
      body: Obx(() => homeController.isLoading()
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : const HomeBody()),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(delegate: SliverChildListDelegate(
          [
            SizedBox(
              height: 200,
              child: Card(
                margin: const EdgeInsets.all(20),
                color: Theme.of(context).colorScheme.onSurface,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Expanded(
                        child: Image.asset(
                          'assets/raqueta-de-padel.png',
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AutoSizeText(
                              'textAppName'.tr,
                              style: GoogleFonts.bebasNeue(fontSize: 52),
                            ),
                            AutoSizeText(
                              'textSportManagement'.tr,
                              style: GoogleFonts.bebasNeue(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: CarouselSlider(
              items: [
                'https://www.pavimentosdeportivos.com/pistas-de-padel/images/Padel-Palacio-Deportes-Benidorm.jpg',
                'https://www.padelnest.com/pictures/pic/GH/GHIH/GHIHXBA69I_x.jpg',
                'https://media.pistaenjuego.ovh/images/center/2/3/2/l.padel-palau-benidorm-1_1610355232.jpg',
                'https://media.pistaenjuego.ovh/images/center/3/3/2/l.padel-palau-benidorm-3_1610355233.jpg'
              ].map((e) => Image.network(e)).toList(),
              options: CarouselOptions(
                height: 300,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
