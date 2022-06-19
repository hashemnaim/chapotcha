import 'dart:io';

import 'package:capotcha/models/cart_modal.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:sqflite/sqflite.dart';

class DBClint {
  DBClint._();
  static final DBClint dbClint = DBClint._();
  Database database;

  static final String tableName = 'cartTable';
  static final String cartonTable = 'cartonTable';
  static final String idCarton = 'carton_id';
  static final String idProduct = 'product_id';
  static final String quntiteyProduct = 'quantity';
  static final String quntiteyCarton = 'quantity';

  Future<Database> initilzeDatabase() async {
    if (database == null) {
      return await connectToDb();
    } else {
      return database;
    }
  }

  Future<Database> connectToDb() async {
    Directory appDocDir = await path.getApplicationDocumentsDirectory();
    String appPath = join(appDocDir.path, "order.db");
    Database db = await openDatabase(
      appPath,
      version: 1,
      onCreate: (db, version) {
        db.execute('''CREATE TABLE $tableName(
          $idProduct INTEGER NOT NULL,
          $quntiteyProduct DOUBLE NOT NULL)''');
        db.execute('''CREATE TABLE $cartonTable(
            $idCarton INTEGER NOT NULL,
            $quntiteyCarton DOUBLE NOT NULL)''');
      },
    );
    return db;
  }

  insertDB(DataCart dataCart) async {
    try {
      database = await initilzeDatabase();

      Map products = await checkProductInCart(dataCart);
      Map<String, dynamic> map = dataCart.toJsonDB();
      double quantity = map['quantity'] ?? 1;
      map['quantity'] = quantity;
      if (products == null) {
        await database.insert(tableName, map);
        DataCart.fromJsonDB(dataCart.toJsonDB());
      } else {
        await updateProductInCartFromOutside(dataCart, products['quantity']);
      }
    } catch (error) {
      throw 'database error $error';
    }
  }

  insertCarton(DataCarontCart carton) async {
    try {
      database = await initilzeDatabase();
      print(carton);
      Map products = await checkcartonInCart(carton);
      Map<String, dynamic> map = carton.toJsonDB();
      double quantity = map['quantity'] ?? 1;
      map['quantity'] = quantity;

      if (products == null) {
        await database.insert(cartonTable, carton.toJsonDB());
        DataCarontCart m = DataCarontCart.fromJsonDB(carton.toJsonDB());
        // print(m.toJsonDB());
      } else {
        print("m.toJsonDB()");

        await updateCartonInCartFromOutside(carton, products['quantity']);
      }
    } catch (error) {
      throw 'database error $error';
    }
  }

  Future<List<Map<String, dynamic>>> getProductDB() async {
    try {
      database = await initilzeDatabase();
      List<Map<String, dynamic>> listRes = await database.query(tableName);
      return listRes;
    } catch (error) {
      throw 'database error $error';
    }
  }

  Future<List<Map<String, dynamic>>> getProductCartonDB() async {
    try {
      database = await initilzeDatabase();
      List<Map<String, dynamic>> listRes = await database.query(cartonTable);
      return listRes;
    } catch (error) {
      throw 'database error $error';
    }
  }

  Future<List<Map<String, dynamic>>> getProdutById(int id) async {
    try {
      database = await initilzeDatabase();
      List<Map<String, dynamic>> product = await database
          .query(tableName, where: '$idProduct = ?', whereArgs: [id]);

      return product;
    } catch (error) {
      throw 'database error $error';
    }
  }

  Future<Map<String, dynamic>> checkProductInCart(DataCart dataCart) async {
    try {
      database = await initilzeDatabase();
      List<Map<String, dynamic>> product = await database.query(tableName,
          where: '$idProduct = ?', whereArgs: [dataCart.productId]);
      if (product.isEmpty || product == null) {
        return null;
      } else {
        return product.first;
      }
    } catch (error) {
      throw 'database error $error';
    }
  }

  Future<Map<String, dynamic>> checkcartonInCart(
      DataCarontCart dataCart) async {
    try {
      database = await initilzeDatabase();
      List<Map<String, dynamic>> product = await database.query(cartonTable,
          where: '$idCarton = ?', whereArgs: [dataCart.cartonId]);
      if (product.isEmpty || product == null) {
        return null;
      } else {
        return product.first;
      }
    } catch (error) {
      throw 'database error $error';
    }
  }

  updateProductInCartFromOutside(DataCart dataCart, double quantitiy) async {
    try {
      database = await initilzeDatabase();

      Map product = dataCart.toJsonDB();

      await database.update(tableName, product,
          where: '$idProduct = ?', whereArgs: [dataCart.productId]);
    } catch (error) {
      throw 'database error $error';
    }
  }

  updateCartonInCartFromOutside(
      DataCarontCart dataCart, double quantitiy) async {
    try {
      database = await initilzeDatabase();

      Map product = dataCart.toJsonDB();

      await database.update(cartonTable, product,
          where: '$idCarton = ?', whereArgs: [dataCart.cartonId]);
    } catch (error) {
      throw 'database error $error';
    }
  }

  Future<double> updateProductInCartFromInside(
      DataCart dataCart, int flag, String unit) async {
    try {
      database = await initilzeDatabase();
      if (flag == 0) {
        if (unit == "كيلو") {
          if (dataCart.quantity > 0.5) {
            dataCart.quantity -= 0.5;
          }
        } else {
          if (dataCart.quantity > 1) {
            dataCart.quantity -= 1.0;
          }
        }
      } else {
        if (unit == "كيلو") {
          dataCart.quantity += 0.5;
        } else {
          dataCart.quantity += 1.0;
        }
      }
      database.update(tableName, dataCart.toJsonDB(),
          where: '$idProduct = ?', whereArgs: [dataCart.productId]);

      return dataCart.quantity;
    } catch (error) {
      throw 'database error $error';
    }
  }

  Future<double> updateCartonInCartFromInside(
      double quantity, int cartonId, int flag, String unit) async {
    try {
      database = await initilzeDatabase();
      if (flag == 0) {
        if (quantity > 1) {
          quantity -= 1.0;
        } else {
          quantity = quantity;
        }
      } else {
        print(quantity);

        quantity += 1.0;
      }

      print(quantity);
      database.update(
          cartonTable, {"carton_id": cartonId, "quantity": quantity},
          where: '$idCarton = ?', whereArgs: [cartonId]);

      return quantity;
    } catch (error) {
      throw 'database error $error';
    }
  }

  Future<int> deleteproduct(DataCart dataCart) async {
    try {
      database = await initilzeDatabase();
      int rows = await database.delete(tableName,
          where: '$idProduct = ?', whereArgs: [dataCart.productId]);

      getProductDB();
      return rows;
    } catch (error) {
      throw 'database error $error';
    }
  }

  Future<int> deleteCarton(id) async {
    print(id);
    try {
      database = await initilzeDatabase();
      int rows = await database
          .delete(cartonTable, where: '$idCarton = ?', whereArgs: [id]);

      return rows;
    } catch (error) {
      throw 'database error $error';
    }
  }

  deleteproductAll() async {
    try {
      database = await initilzeDatabase();
      await database.delete(
        tableName,
      );
      await database.delete(
        cartonTable,
      );
    } catch (error) {
      throw 'database error $error';
    }
  }
}
