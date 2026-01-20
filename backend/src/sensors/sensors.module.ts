import { Module } from '@nestjs/common';
import { SensorsController } from './sensors.controller';
import { SensorsService } from './sensors.service';
import { SensorsGateway } from './sensors.gateway';

@Module({
  controllers: [SensorsController],
  providers: [SensorsService, SensorsGateway],
  exports: [SensorsService, SensorsGateway],
})
export class SensorsModule {}
