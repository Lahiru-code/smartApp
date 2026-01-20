import { Test, TestingModule } from '@nestjs/testing';
import { AppController } from './app.controller';
import { AppService } from './app.service';

describe('AppController', () => {
  let appController: AppController;

  beforeAll(async () => {
    const app: TestingModule = await Test.createTestingModule({
      controllers: [AppController],
      providers: [AppService],
    }).compile();

    appController = app.get<AppController>(AppController);
  });

  it('should return health ok', () => {
    expect(appController.getHealth()).toEqual({ status: 'ok' });
  });

  it('should return hello message', () => {
    expect(appController.getHello()).toEqual({ message: 'Welcome to smartapp-backend' });
  });
});
