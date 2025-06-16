## How to integrate the generated code.

### 1. Add Routes in the  case '/src/core/routes/routes.dart' file
         return BlogsScreen.genRouteconfig file

```text
 case XXXScreen.routeName:
         return XXXScreen.genRoute();
```

### 2. Add the menuoption in the ./widgets/app_drawer.dart file
         

 

```text

  final List<Map<String, String>> tiles =  const [
    {'label': XXXScreen.labelName, "path": XXXScreen.routeName},
    ,
  ];
```

### 3. Add export reference to the new file in ./screens/screens.dart file

```text

  export 'xxx_screen.dart';
```
