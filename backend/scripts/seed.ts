import { PrismaClient } from '@prisma/client';
import * as argon2 from 'argon2';

const prisma = new PrismaClient();

async function main() {
  // Create a test user with email 123456@classroom.com
  const email = '123456@classroom.com';
  const password = 'password123';

  const passwordHash = await argon2.hash(password);

  const user = await prisma.user.upsert({
    where: { email },
    update: {},
    create: {
      email,
      passwordHash,
    },
  });

  console.log('✅ User created/updated:', user.email);
  console.log('📧 Email:', email);
  console.log('🔐 Password:', password);
  console.log('\nYou can now login with these credentials!');
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
