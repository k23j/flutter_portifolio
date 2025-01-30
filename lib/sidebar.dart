import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  final List<String> pageTitleList;
  final int currentPage;
  final void Function(int id) onChangePage;

  const Sidebar(
    this.currentPage,
    this.pageTitleList, {
    required this.onChangePage,
    super.key,
  });

  bool isCurrentPage(int id) {
    return id == currentPage;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 150, maxHeight: 400),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: pageTitleList.length,
        itemBuilder: (context, index) => Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => onChangePage(index),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: isCurrentPage(index)
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Theme.of(context).colorScheme.primaryContainer)
                  : null,
              child: Text(
                pageTitleList[index],
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: isCurrentPage(index)
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onSecondary,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
