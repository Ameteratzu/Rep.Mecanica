# app/dao/ubigeo_dao.py

from app.models.ubigeo import Ubigeo
from app.extensions import db

class UbigeoDAO:
    @staticmethod
    def obtener_todos():
        """
        Retorna una lista de todos los ubigeos ordenados por departamento, provincia y distrito.
        """
        return Ubigeo.query.order_by(
            Ubigeo.departamento,
            Ubigeo.provincia,
            Ubigeo.distrito
        ).all()

    @staticmethod
    def buscar_por_id(ubigeo_id):
        """
        Obtiene un ubigeo por su ID. Devuelve None si no existe.
        """
        return Ubigeo.query.get(ubigeo_id)

    @staticmethod
    def eliminar(ubigeo_id):
        """
        Elimina un ubigeo por su ID. Maneja transacción y rollback.
        """
        ub = Ubigeo.query.get(ubigeo_id)
        if not ub:
            return {"success": False, "message": "Ubigeo no encontrado"}
        try:
            db.session.delete(ub)
            db.session.commit()
            return {"success": True, "message": "Ubigeo eliminado correctamente"}
        except Exception as e:
            db.session.rollback()
            return {"success": False, "message": f"Error al eliminar el ubigeo: {e}"}

    @staticmethod
    def guardar(ubigeo: Ubigeo):
        """
        Persiste una instancia de Ubigeo.
        Si ubigeo.id existe, actualiza; si no, crea uno nuevo.
        """
        try:
            if ubigeo.id:
                db.session.merge(ubigeo)
                mensaje = "Ubigeo actualizado correctamente"
            else:
                db.session.add(ubigeo)
                mensaje = "Ubigeo registrado correctamente"

            db.session.commit()
            return {"success": True, "message": mensaje}
        except Exception as e:
            db.session.rollback()
            return {"success": False, "message": f"Error al guardar el ubigeo: {e}"}
