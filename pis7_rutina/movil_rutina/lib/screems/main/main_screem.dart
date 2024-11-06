import 'package:flutter/material.dart';
import 'package:movil_rutina/views/home_rutina.dart';
import 'package:movil_rutina/views/calendar_dias.dart';


class MainScreem extends StatefulWidget {
  const MainScreem({super.key});

  @override
  State<MainScreem> createState() => _MainScreemState();
}

class _MainScreemState extends State<MainScreem> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final screems= [const HomeRutina(),  CalendarDias()];
    return Scaffold(

      body: IndexedStack(
        index: selectedIndex,
        children: screems,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.home_filled),
              activeIcon: const Icon(Icons.home),
              label: "  ",
              backgroundColor: colors.primary),
          BottomNavigationBarItem(
            icon: const Icon(Icons.calendar_month),
            activeIcon: const Icon(Icons.calendar_month_outlined),
            label: " ",
            backgroundColor: colors.tertiary,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.add_box),
            activeIcon: const Icon(Icons.add),
            label: "    ",
            backgroundColor: colors.primary,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.stacked_bar_chart),
            activeIcon: const Icon(Icons.stacked_line_chart),
            label: "     ",
            backgroundColor: colors.primary,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_3_outlined),
            activeIcon: const Icon(Icons.person_3),
            label: "",
            backgroundColor: colors.tertiary,
          ),
        ],
      ),
    );
  }
}
