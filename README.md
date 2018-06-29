# clean-slate

Clean Slate workflow for Prisoners With Children

Check out our navigator [here!](http://www.alxmnn.com/clean-slate/)

## Disclaimer

The advice you find herein is not the same as legal counsel. Please seek a
lawyer to help with your matters.

The creators of this Github Repo take no responsibility for the accuracy of
information herein.

## To Develop

Install `elm-app` (assume you have `npm`, if you don't `homebrew` or whatever):

```
npm install create-elm-app -g
```

Then:

```
cd app;
elm-app start;
```

## To Deploy

_TODO: CI_

```
rm -rf docs/ app/build/; \
cd app/; \
PUBLIC_URL=./ elm-app build; \
cd ..; \
mkdir docs/; \
mv app/build/* docs/; \
sed -e "s/# CURRENT SHA.*/# CURRENT SHA `git rev-parse HEAD`/g" app.appcache >> docs/app.appcache; \
git add docs/; \
git commit -m "deploy version"; \
git push origin master;
```

## Cache Busting

This app uses HTML 5 App Manifests to get latest content from the site.

To verify that your browser is respecting the cache busting, check here for:

* [Chrome](chrome://appcache-internals/#)
