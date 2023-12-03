-- CreateTable
CREATE TABLE "CoinHistory" (
    "id" SERIAL NOT NULL,
    "coinId" TEXT NOT NULL,
    "currency" TEXT NOT NULL,
    "price" DECIMAL(65,30) NOT NULL,
    "date" INTEGER NOT NULL,

    CONSTRAINT "CoinHistory_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserSubscription" (
    "id" SERIAL NOT NULL,
    "userId" TEXT NOT NULL,
    "coinId" TEXT NOT NULL,
    "currency" TEXT NOT NULL,
    "threshold" DECIMAL(65,30) NOT NULL,

    CONSTRAINT "UserSubscription_pkey" PRIMARY KEY ("id")
);
