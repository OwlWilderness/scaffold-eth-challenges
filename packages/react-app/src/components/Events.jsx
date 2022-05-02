import { List } from "antd";
import { useEventListener } from "eth-hooks/events/useEventListener";
import { Address, TokenBalance } from "../components";

/*
  ~ What it does? ~

  Displays a lists of events

  ~ How can I use? ~

  <Events
    contracts={readContracts}
    contractName="YourContract"
    eventName="SetPurpose"
    localProvider={localProvider}
    mainnetProvider={mainnetProvider}
    startBlock={1}
  />
*/

export default function Events({ contracts, contractName, eventName, localProvider, mainnetProvider, startBlock }) {
  // 📟 Listen for broadcast events
  const events = useEventListener(contracts, contractName, eventName, localProvider, startBlock);

  return (
    <div style={{ width: 600, margin: "auto", marginTop: 32, paddingBottom: 32 }}>
      <h2>
        {eventName} Events
        <br />
        {eventName === "RegisterEvent"
          ? " ⟠ Address | Art Contract | Issued | Available | Voted"
          : eventName === "HeartArtEvent"
          ? " ⟠ Address | Art Contract | Issued | Available | Voted  "
          :"some unknown event headers " }
      </h2>
      <List
        bordered
        dataSource={events}
        renderItem={item => {
          return (
            <List.Item key={item.blockNumber + "_" + item.args[0].toString()}>

              <Address address={item.args[0]} ensProvider={mainnetProvider} fontSize={16} />
              { `|`  }
              <Address address={item.args[1][0]} ensProvider={mainnetProvider} fontSize={16} />
              
              { `|${item.args[1][1]}`  }

              { `|${item.args[1][2]}`}

              { `|${item.args[1][3]}`}
            </List.Item>
          );
        }}
      />
    </div>
  );
}
