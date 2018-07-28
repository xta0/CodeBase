var gulp = require('gulp'),
sass = require('gulp-sass')
// autoprefixer = require('autoprefixer')


gulp.task('styles', function() {
  return gulp.src('./app/assets/styles/style.scss')
    .pipe(sass())
    .on('error', function(errorInfo) {
      console.log(errorInfo.toString());
      this.emit('end');
    })
    // .pipe(autoprefixer())
    .pipe(gulp.dest('./app/build/styles'));
});