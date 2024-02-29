# SVExhaustiveTester
Cycle-bound exhaustive differential tester for two logically equivalent SV designs.  

## Dependencies  
```sh
sudo apt install python3 pip
pip install bitvector tqdm 
```
You will also need the Synopsys VCS simulator.  

## Use  
```sh
python exhaust.py <n: int> [optional]<rand: bool> [optional]<max_gen: int>
```
