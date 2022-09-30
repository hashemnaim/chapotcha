import 'package:capotcha/modules/Cart/model/cart_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../utils/constants.dart';

class DBHelper {
  static Database? _db;
  DBHelper._();

  static final DBHelper dbHelper = DBHelper._();

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  initDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'cart.db');

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE ${Constants.TableCartName}(
          ${Constants.ColumnId} INTEGER PRIMARY KEY,
          ${Constants.ColumnName} TEXT NOT NULL,
          ${Constants.ColumnImage} TEXT NOT NULL,
          ${Constants.ColumnUnit} TEXT NOT NULL,
          ${Constants.ColumnPrice} TEXT NOT NULL,
          ${Constants.ColumnMaxQuantity} TEXT NOT NULL,
          ${Constants.ColumnStock} TEXT NOT NULL,
          ${Constants.quntiteyProduct} TEXT NOT NULL)''');
  }

  Future<CartModel> insert(CartModel cartModel) async {
    var dbClient = await (db);
    await dbClient!.insert(Constants.TableCartName, cartModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return cartModel;
  }

  Future<CartModel> update(CartModel cartModel) async {
    var dbClient = await (db);
    await dbClient!.update(Constants.TableCartName, cartModel.toMap(),
        where: '${Constants.ColumnId} = ?', whereArgs: [cartModel.productId]);
    return cartModel;
  }

  Future<CartModel> delate(CartModel cartModel) async {
    var dbClient = await (db);
    await dbClient!.delete(Constants.TableCartName,
        where: '${Constants.ColumnId} = ?', whereArgs: [cartModel.productId]);
    return cartModel;
  }

  Future<List<CartModel>> getAllProduct() async {
    var dbClient = await (db);
    List<Map> maps = await dbClient!.query(Constants.TableCartName);
    List<CartModel> list = maps.isNotEmpty
        ? maps
            .map((e) => CartModel.fromJson(e as Map<String, dynamic>))
            .toList()
        : [];
    return list;
  }

  deleteproductAll() async {
    try {
      var dbClient = await (db);
      await dbClient!.delete(
        Constants.TableCartName,
      );
      getAllProduct();
    } catch (error) {
      throw 'database error $error';
    }
  }
}
