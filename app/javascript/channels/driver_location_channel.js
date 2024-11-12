import { createConsumer } from "@rails/actioncable"

const consumer = createConsumer("ws://localhost:3000/cable")

consumer.subscriptions.create({ channel: "VehicleLocationChannel", vehicle_id: "123" }, {
  received(data) {
    // Aquí recibes los datos del servidor
    console.log("Datos recibidos:", data);
    // Aquí puedes actualizar los iconos en el mapa con la nueva latitud y longitud
    updateVehicleLocation(data);  // Método que actualiza el mapa
  }
});

function updateVehicleLocation(data) {
  // Lógica para mover el marcador del vehículo en el mapa con los nuevos datos
  const vehicleMarker = L.marker([data.lat, data.lon]).addTo(map);
  vehicleMarker.bindPopup(data.name).openPopup();
}
