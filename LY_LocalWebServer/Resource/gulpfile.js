/**
 * Created by Administrator on 2017/2/13.
 */
var path = require('path');
var gulp = require('gulp');
var concat = require('gulp-concat');
var connect = require('gulp-connect');
var cssmin = require('gulp-cssmin');
var rename = require('gulp-rename');
var sass = require('gulp-sass');
var uglify = require('gulp-uglify');
var watch = require('gulp-watch');

var distpath = __dirname;
var sasspath = distpath+'/sass';//sass目录
var csspath = distpath+'/css';//css目录

gulp.task('buildcss',function(){//scss编译为css
    gulp.src(sasspath+'/*.scss')
        .pipe(sass())
        .pipe(gulp.dest(csspath))
})

gulp.watch(sasspath+'/*.scss',['buildcss']);