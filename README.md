## Web Work Flow

### Gulp

[What is Gulp](https://gulpjs.com/)

#### 1. Install gulp globally:

__If you have previously installed a version of gulp globally, please run `npm rm --global gulp`
to make sure your old version doesn't collide with gulp-cli.__

```sh
$ npm install --global gulp-cli
```

#### 2. Install gulp in your project devDependencies:

```sh
$ npm install gulp --save-dev
```

#### 3. Create a `gulpfile.js` at the root of your project:

```js
var gulp = require('gulp');
gulp.task('default', function() {
  // place code for your default task here
});
```

#### 4. Run gulp:

```sh
$ gulp <task_name>
```

### Webpack

[What is Webpack](https://webpack.js.org/)

