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
import inet.node.inet.WirelessHost;
import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.node.wireless.AccessPoint;
import inet.node.ethernet.*;

network WirelessNetwork {
	parameters:
        int numCliG1 = default(3);
        int numCliG2 = default(3);
        
        @statistic[globalPacketSent](title="global packets sent"; source=packetSent; record=count/2);
        @statistic[globalPacketReceived](title="global packets received"; source=packetReceived; record=count/2);
        @statistic[globalThroughput](title="global throughput"; unit=bps; source="throughput(packetReceived)/2"; record=vector);
        @statistic[globalEndToEndDelay](title="global end-to-end delay"; source="dataAge(packetReceived)"; unit=s; record=histogram,vector; interpolationmode=none);
    submodules:
        configurator: Ipv4NetworkConfigurator;
        cliG1[numCliG1]: WirelessHost;
        cliG2[numCliG2]: WirelessHost;
        server: WirelessHost;
        router: Router;
        ap: AccessPoint;
        
    connections:
	
}