FUNCTION BUILD($CONFIG) {
	WRITE-HOST "Downloading dependencies..."
	go get -d
	WRITE-HOST "DONE"
	WRITE-HOST ""

	WRITE-HOST "Building project..."
	FOREACH ($OS in $CONFIG.BUILD.Keys) {
		FOREACH ($ARCH in $CONFIG.BUILD[$OS]) {
			$FILENAME = "$( $CONFIG.PROJECT_NAME )-$OS-$ARCH"
			IF ($OS -EQ "windows") {
				$FILENAME = "$FILENAME.exe"
			}
			
			WRITE-HOST "$FILENAME - " -NoNewline

			$ENV:GOOS = $OS
			$ENV:GOARCH = $ARCH
			go build -gcflags=all="-B" -ldflags="-s -w" -trimpath -o="bin/$FILENAME"

			WRITE-HOST "DONE"
		}
	}
}



BUILD @{
	PROJECT_NAME = "mcods"
	BUILD = @{
		"windows" = @("amd64", "386")
		"linux" = @("amd64", "386")
	}
}