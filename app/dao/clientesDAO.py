# app/dao/clientes_dao.py

from app.models.cliente import Cliente
from app.extensions import db

class ClientesDAO:
    @staticmethod
    def obtener_todos():
        """
        Retorna una lista de todos los clientes registrados.
        """
        return Cliente.query.all()

    @staticmethod
    def buscar_por_id(cliente_id):
        """
        Obtiene un cliente por su ID. Devuelve None si no existe.
        """
        return Cliente.query.get(cliente_id)

    @staticmethod
    def eliminar(cliente_id):
        """
        Elimina el cliente con el ID dado y todas sus dependencias (cascada manejada por FK).
        Retorna un dict con success y message.
        """
        cliente = Cliente.query.get(cliente_id)
        if not cliente:
            return {"success": False, "message": "Cliente no encontrado"}
        try:
            db.session.delete(cliente)
            db.session.commit()
            return {"success": True, "message": "Cliente eliminado correctamente"}
        except Exception as e:
            db.session.rollback()
            return {"success": False, "message": f"Error al eliminar el cliente: {e}"}

    @staticmethod
    def guardar(cliente: Cliente):
        """
        Persiste una instancia de Cliente. Si cliente.id está definido, actualiza;
        de lo contrario, crea un nuevo registro.
        Retorna un dict con success y message.
        """
        try:
            if cliente.id:
                db.session.merge(cliente)
                mensaje = "Cliente actualizado correctamente"
            else:
                db.session.add(cliente)
                mensaje = "Cliente registrado correctamente"

            db.session.commit()
            return {"success": True, "message": mensaje}
        except Exception as e:
            db.session.rollback()
            return {"success": False, "message": f"Error al guardar el cliente: {e}"}