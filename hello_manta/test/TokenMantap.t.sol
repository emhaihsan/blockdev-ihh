import {Test, console} from "../lib/forge-std/src/Test.sol";
import {TokenMantap} from "../src/TokenMantap.sol";

contract TokenMantapTest is Test {
    TokenMantap public token;

    address public agus = makeAddr("agus");
    address public bambang = makeAddr("bambang");

    function setUp() public {
        token = new TokenMantap();
    }

    function test_mint() public {
        assertEq(
            token.totalSupply(),
            1_000_000_000_000_000e18,
            "Total Supply tidak 1 Triliun"
        );
    }

    function test_transfer() public {
        token.transfer(bambang, 100e18);
        assertEq(
            token.balanceOf(bambang),
            100e18,
            " Bambang tidak mendapatkan 100 MTP"
        );
        console.log("Bambang balance: ", token.balanceOf(bambang));

        token.transfer(agus, 100e18);
        assertEq(
            token.balanceOf(agus),
            100e18,
            " Agus tidak mendapatkan 100 MTP"
        );
        console.log("Agus balance: ", token.balanceOf(agus));
    }
}
