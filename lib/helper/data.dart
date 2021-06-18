import 'package:news/models/category_model.dart';
//top of homepage we have
//list of categories  with names with photos
List<Category_model> getCategories() {
  List<Category_model> category_model = new List<Category_model>();
  Category_model cm = new Category_model();
  cm.name = "Business";
  cm.image =
      "https://images.unsplash.com/photo-1507679799987-c73779587ccf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1502&q=80";
  category_model.add(cm);

   
  cm = new Category_model();
  cm.name = "Entertainment";
  cm.image =
      "https://images.unsplash.com/photo-1522869635100-9f4c5e86aa37?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80";
  category_model.add(cm);

  
  cm = new Category_model();
  cm.name = "General";
  cm.image =
      "https://images.unsplash.com/photo-1495020689067-958852a7765e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60";
  category_model.add(cm);

   
  cm = new Category_model();
  cm.name = "Health";
  cm.image =
      "https://images.unsplash.com/photo-1494390248081-4e521a5940db?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1595&q=80";
  category_model.add(cm);

   
  cm = new Category_model();
  cm.name = "Science";
  cm.image =
      "https://images.unsplash.com/photo-1554475901-4538ddfbccc2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1504&q=80";
  category_model.add(cm);
 
  cm = new Category_model();
  cm.name = "Sports";
  cm.image =
      "https://images.unsplash.com/photo-1495563923587-bdc4282494d0?ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80";
  category_model.add(cm);

   
  cm = new Category_model();
  cm.name = "Technology";
  cm.image =
      "https://images.unsplash.com/photo-1519389950473-47ba0277781c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80";
  category_model.add(cm);
  return category_model;
}
