#include <iostream>
#include "lamp.h"
#include "mixer.h"
#include "coinbox.h"
#include "billbox.h"

int
main()
{
  Lamp lamp;
  Mixer mixer;
  CoinBox coinBox;
  BillBox billBox;

  mixer.SetLamp(&lamp);
  mixer.SetCoinBox(&coinBox);
  mixer.SetBillBox(&billBox);

  coinBox.SetLamp(&lamp);
  coinBox.SetMixer(&mixer);
  coinBox.SetBillBox(&billBox);

  billBox.SetLamp(&lamp);
  billBox.SetMixer(&mixer);
  billBox.SetCoinBox(&coinBox);

  // -- 20 ���� ���� ����
  for (int i = 0; i < 90; i++)
    coinBox.InsertCoin();

  // -- ���� & ���� 
  mixer.OutOfOrder();
  coinBox.InsertCoin();
  billBox.InsertBill();
  mixer.Repair();

  billBox.InsertBill(8);
}