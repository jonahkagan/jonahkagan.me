rm -rf prod
wintersmith build
mkdir prod
cp -R build prod/build
cp -R bin prod/bin
cp -R node_modules prod/node_modules
cp package.json prod/package.json
cp Procfile prod/Procfile

