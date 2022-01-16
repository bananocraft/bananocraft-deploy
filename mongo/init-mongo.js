conn = new Mongo();
db = conn.getDB("BananoCraft");

db.createCollection("users")