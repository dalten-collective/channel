import React, { useEffect, useState } from "react";
import { Link } from "react-router-dom";

export function Home() {
  const [providers, setProviders] = useState<string[]>([]);
  const [boards, setBoards] = useState({});

  useEffect(() => {
    const init = async () => {
      const providers = await api.scry({
        app: "channel-client",
        path: "/providers",
      });
      setProviders(providers["providers"]);
    };
      init();
  }, []);

  useEffect(() => {
    const init = async () => {
        let newBoards = {};
        providers.forEach(async (ship) => {
          const board = await window.api.scry({ app: "channel-client", path: `/boards/${ship}`});
          newBoards[ship] = board;
        });
        // const scries = providers.map((provider) => ({prov: provider, scry: {
        //   app: "channel-client",
        //   path: `/boards/${provider}`,
        // }}));
        // newBoards = await Promise.all(scries.map((e) => api.scry(e.scry)));
        setBoards(newBoards);
    };
    init();
  }, [providers]);

  const addHost = () => {
    const ship = window.prompt("What ship? eg. ~zod");
    return window.api
      .poke({
        app: "channel-client",
        mark: "channel-stacy",
        json: {
          "see-hoast": ship,
        },
      })
      .then(() => location.reload());
  };

  return (
    <main className="flex flex-col items-center justify-center min-h-screen space-y-3 lg:space-y-0">
      <div className="max-w-prose justify-center p-6 grid grid-rows-1 gap-2">
        <h2 className="font-bold text-chan-red text-8xl text-center">
          channel
        </h2>
        <h2 className="text-chan-red text-4xl text-center border-chan-border">
          boards:
        </h2>
      </div>

      <div className="w-full flex flex-col overflow-y-auto justify-between h-96 max-w-prose border-b-8 p-6 my-4 bg-chan-element border-chan-border outline outline-1 outline-black z-10">
        <div>
          {Object.entries(boards).map(([key, value]) => {
            return (
              <div key={`container-${key}`}>
                <h2
                  className="font-semibold px-1 bg-chan-border"
                  key={`header-${key}`}
                >
                  {key}:
                </h2>
                {value["boards"].map((board, i) => (
                  <Link
                    className="text-link-blue px-1 hover:text-link-hover hover:underline"
                    to={`/board/${key}/${board.board}`}
                    key={`link-${i}`}
                  >
                    /{board.board}/
                  </Link>
                ))}
              </div>
            );
          })}
        </div>
        <p
          onClick={() => addHost()}
          className="uppercase font-bold text-right cursor-pointer"
        >
          Add provider
        </p>
      </div>
      <p>Use at your own risk.</p>
    </main>
  );
}
