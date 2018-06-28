# clean-slate
Clean Slate workflow for Prisoners With Children

Check out our navigator [here!](http://www.alxmnn.com/clean-slate/)

## Disclaimer
The advice you find herein is not the same as legal counsel. Please seek a lawyer to help with your matters.

The creators of this Github Repo take no responsibility for the accuracy of information herein.

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
git commit -m "deploy versions"; \
git push origin master;
```