import {
  WebSocketGateway,
  WebSocketServer,
  SubscribeMessage,
  MessageBody,
  ConnectedSocket,
} from '@nestjs/websockets';
import { Server, Socket } from 'socket.io';
import { SensorsService } from './sensors.service';

@WebSocketGateway({ cors: true })
export class SensorsGateway {
  @WebSocketServer()
  server: Server;

  constructor(private sensors: SensorsService) {}

  @SubscribeMessage('subscribe')
  handleSubscribe(@MessageBody() deviceId: string, @ConnectedSocket() client: Socket) {
    client.join(`device:${deviceId}`);
    return { event: 'subscribed', deviceId };
  }

  @SubscribeMessage('unsubscribe')
  handleUnsubscribe(@MessageBody() deviceId: string, @ConnectedSocket() client: Socket) {
    client.leave(`device:${deviceId}`);
    return { event: 'unsubscribed', deviceId };
  }

  async broadcastReading(deviceId: string, reading: any) {
    this.server.to(`device:${deviceId}`).emit('reading', reading);
  }
}
