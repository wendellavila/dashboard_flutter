import 'package:flutter/material.dart';

import 'navigation_data.dart';
import '../ui/widgets/sidebar.dart';

final NavigationData navigationData = NavigationData.singletonInstance;

//PageStorage for storing and restoring sidebar scroll position across all pages
final PageStorage sidebarScrollStorage = PageStorage(
  bucket: PageStorageBucket(),
  key: const PageStorageKey('sidebar'),
  child: SideBar(),
);
