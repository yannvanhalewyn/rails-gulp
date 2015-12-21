var gulp       = require('gulp');
var browserify = require('browserify');
var babelify   = require('babelify');
// var es6ify     = require('es6ify')
// var reactify   = require('reactify');
var babelify = require('babelify');
var sass       = require('gulp-sass');
var source     = require('vinyl-source-stream');

gulp.task('css', function() {
  gulp.src('app/assets/stylesheets/index.scss')
  .pipe(sass().on('error', sass.logError))
  .pipe(gulp.dest('public/css'))
});

gulp.task('css:watch', function() {
  gulp.watch('app/assets/stylesheets/**/*.scss', [ 'css' ])
});

var entry = 'app/assets/javascripts/index.js'

gulp.task('js', function() {
  browserify(entry)
  .transform(babelify, {presets: ['es2015', 'react']})
  .bundle()
  .on('error', (e) => console.log(e.toString()))
  .pipe(source('bundle.js'))
  .pipe(gulp.dest('public/js'))
});

gulp.task('js:watch', function() {
  gulp.watch('app/assets/javascripts/**/*', ['js'])
});

gulp.task('production', ['css', 'js'])

gulp.task('default', ['js:watch', 'css:watch']);
