#name "Turbo Cup"
#author "Chrizonix"

// Globals
CreateUI g_createUI;

bool g_status = false;
bool g_recordingEnabled = false;

class CreateUI
{
	bool m_visible = false;
		
	string m_txtStart = "Start";
	string m_txtStop = "Stop";
	
	void Render()
	{
		if (!m_visible) {
			return;
		}
		
		if (UI::Begin("Turbo Cup - Control Panel", m_visible)) {
			auto app = GetApp();
			auto appClass = Reflection::TypeOf(app);
			
			// Start Button
			if (UI::Button(m_txtStart)) {
				if (!g_recordingEnabled) {
					m_txtStart = "Recording is active!";
					startnew(RecordingCoroutine);
					print("Started Recording!");
				}
			}
			
			// Stop Button
			if (UI::Button(m_txtStop)) {
				if (g_recordingEnabled) {
					g_recordingEnabled = false;
					m_txtStart = "Start";
					print("Stopped Recording!");
				}
			}
		}
		UI::End();
	}
}

// This is the function for the coroutine we created in Main().
void RecordingCoroutine()
{
	// Get Server Reference
	auto app = cast<CGameManiaPlanet>(GetApp());
	auto menus = cast<CTrackManiaMenus>(app.MenuManager);
	auto network = cast<CTrackManiaNetwork>(app.Network);
	auto server = cast<CNetServer>(network.Server);
	auto scriptApi = cast<CGameManiaPlanetScriptAPI>(app.ManiaPlanetScriptAPI);
	
	// Start Recording
	g_recordingEnabled = true;
	
	// While Recording is Active
	while (g_recordingEnabled) {
		// Set Status
		g_status = false;
		
		// Get Player Infos
		MwBuffer<CGameNetPlayerInfo@> players = network.PlayerInfos;
		
		// Get Current Map
		CGameCtnChallenge@ currentMap = scriptApi.CurrentMap;
		
		// Check Current Map
		if (currentMap !is null) {
			// Get Map Info
			CGameCtnChallengeInfo@ mapInfo = currentMap.MapInfo;
			
			// Get Map Name
			if (mapInfo !is null) {
				// Prepare Network Message
				string playerRecords;
				
				// Append Map Name
				playerRecords += (mapInfo.MapUid + "\x1F" + mapInfo.Name) + "\x1E";
			
				// Get Player Scores
				for (uint i = 0; i < players.Length; ++i) {
					CTrackManiaPlayerInfo@ player = cast<CTrackManiaPlayerInfo@>(players[i]);
					CTrackManiaScore@ score = player.RaceScore;
					
					if (score !is null) {
						string playerName = player.Name;
						playerRecords += (playerName + "\x1F" + player.Login + "\x1F" + score.BestTime + "\x1F" + score.LastRaceTime) + "\x1E";
					}
				}

				// Check Players
				if (players.Length > 0) {
					// Send Records to Server
					SendNetwork(playerRecords);
				
					// Print Infos
					print("Successfully sent " + players.Length + " record(s) to server.");
				}
			}
		}
		
		// Successful
		g_status = true;

		// Sleep for Milliseconds
		sleep(5000);
	}
}

void SendNetwork(string msg)
{
	// Create a new socket.
	auto sock = Net::Socket();

	// Try to initiate a socket to icanhazip.com on port 80.
	if (!sock.Connect("127.0.0.1", 23456)) {
		// If it failed, there was some socket error. (This is not necessarily
		// a connection error!)
		print("Couldn't initiate socket connection.");
		return;
	}

	// Wait until we are connected. This is indicated by whether we can write
	// to the socket.
	while (!sock.CanWrite()) {
		yield();
	}

	// Send raw data (as a string) to the server.
	if (!sock.WriteRaw(
		msg + "\r\n" +
		"\r\n"
	)) {
		// If this fails, the socket might not be open. Something is wrong!
		print("Couldn't send data.");
		return;
	}

	for (int i = 0; i < 10; i++) {
		// If there is no data available yet, yield and wait.
		while (sock.Available() == 0) {
			yield();
		}

		// There's buffered data! Try to get a line from the buffer.
		string line;
		if (!sock.ReadLine(line)) {
			// We couldn't get a line at this point in time, so we'll wait a
			// bit longer.
			yield();
			continue;
		}

		// We got a line! Trim it, since ReadLine() returns the line including
		// the newline characters.
		line = line.Trim();

		// If the line is empty, we are done reading all headers.
		if (line == "") {
			break;
		}
	}

	// Close the socket.
	sock.Close();
}

void Render()
{	
	if (g_recordingEnabled) {
		Draw::FillRect(vec4(
			10,
			10,
			70,
			24
		), vec4(0, 0, 0, 0.70f), 3.0f);
	
		vec4 color = vec4(0.14, 0.94, 0.45, 1);
		string text = "Running";
		
		if (g_status == false) {
			color = vec4(1, 0, 0, 1);
			text = "Error";
		}
		
		Draw::DrawString(vec2(
			20,
			14
		), color, text);
	}
}

void RenderMenu()
{
	if (UI::BeginMenu("Turbo Cup")) {	
		if (UI::MenuItem("Control Panel", "", g_createUI.m_visible) && !g_createUI.m_visible) {
			g_createUI.m_visible = !g_createUI.m_visible;
		}
		
		UI::EndMenu();
	}
}

void RenderInterface()
{
	g_createUI.Render();
}

void Main()
{

}
