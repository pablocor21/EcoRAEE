/// Tipos de movimiento en el ciclo de vida de un dispositivo RAEE.
enum TipoMovimiento {
  registro,
  solicitudCreada,
  aceptado,
  enTransito,
  recibidoPunto,
  recibidoEmpresa,
  enClasificacion,
  enDesmantelamiento,
  enReciclaje,
  reciclado,
  certificadoEmitido;

  String get icono => switch (this) {
    registro            => '📱',
    solicitudCreada     => '📋',
    aceptado            => '✅',
    enTransito          => '🚚',
    recibidoPunto       => '📍',
    recibidoEmpresa     => '🏭',
    enClasificacion     => '🔍',
    enDesmantelamiento  => '🔧',
    enReciclaje         => '♻️',
    reciclado           => '🌿',
    certificadoEmitido  => '📄',
  };

  String get label => switch (this) {
    registro            => 'Dispositivo registrado',
    solicitudCreada     => 'Solicitud creada',
    aceptado            => 'Solicitud aceptada',
    enTransito          => 'En tránsito',
    recibidoPunto       => 'Recibido en punto',
    recibidoEmpresa     => 'Recibido en empresa',
    enClasificacion     => 'En clasificación',
    enDesmantelamiento  => 'En desmantelamiento',
    enReciclaje         => 'En proceso de reciclaje',
    reciclado           => 'Reciclaje completado',
    certificadoEmitido  => 'Certificado emitido',
  };
}
