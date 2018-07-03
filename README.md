# clean-slate

Clean Slate workflow for Prisoners With Children

Check out our navigator [here!](http://www.alxmnn.com/clean-slate/)

## A note on use

**_You are welcome to use this material, but please do not charge for any
services related to its use._**

## Disclaimer for non-attorneys

This app is **_not intended to answer all your legal questions or take the place
of an attorney._** Legal Services for Prisoners with Children (LSPC) does not
provide direct legal representation. Laws and policies are subject to frequent
change; it is your responsibility to make sure the information is up to date.
The information in this app is based on California law only and is not
applicable in other states.

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
