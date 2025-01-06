//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/.
// 

package inet_upo_ws_2025.simulations;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.node.ethernet.*;


network WiredNetwork {
    parameters:
        int numCliG1 = default(3);
        int numCliG2 = default(3);
        
        @statistic[globalPacketSent](title="global packets sent"; source=packetSent; record=count/2);
        @statistic[globalPacketReceived](title="global packets received"; source=packetReceived; record=count/2);
        @statistic[globalThroughput](title="global throughput"; unit=bps; source="throughput(packetReceived)/2"; record=vector);
        @statistic[globalEndToEndDelay](title="global end-to-end delay"; source="dataAge(packetReceived)"; unit=s; record=histogram,vector; interpolationmode=none);
    submodules:
        configurator: Ipv4NetworkConfigurator;
        router: Router;
        switch[2]: EthernetSwitch;
        cliG1[numCliG1]: StandardHost;
        cliG2[numCliG2]: StandardHost;
        server: StandardHost;
        
    connections:
        for k=0..sizeof(switch)-1 {
        	switch[k].ethg++ <--> Eth100M {per = 0.1;} <--> router.ethg++;
        }
        for i=0..numCliG1-1 {
        	cliG1[i].ethg++ <--> Eth100M {per = 0;} <--> switch[0].ethg++;
        }
        for j=0..numCliG2-1 {
        	cliG2[j].ethg++ <--> Eth100M {per = 0;} <--> switch[1].ethg++;
        }
        
        server.ethg++ <--> Eth100M <--> router.ethg++;
        
        
}
