var gulp = require('gulp');
var watch = require('gulp-watch');
var postcss = require('gulp-postcss');
var autoprefixer = require('autoprefixer');
var cssvars = require('postcss-simple-vars');
var nested = require('postcss-nested');
var cssimport = require('postcss-import');

gulp.task('html',function(){
    console.log("Gulp Watching Started!");
});
gulp.task('style',function(){
    return gulp.src('./app/assets/styles/style.css')
    .pipe(postcss([cssimport,autoprefixer,cssvars,nested]))
    .pipe(gulp.dest('./app/temp/styles'));
});

gulp.task('watch', function(){
    watch('./app/index.html',()=>{
        gulp.start('html');
    });
    watch('./app/assets/styles/**/*.css',function(){
        gulp.start('style');
    })
});