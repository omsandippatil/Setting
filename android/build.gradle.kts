import org.gradle.api.tasks.Delete
import java.io.File

buildscript {
    val kotlin_version = "1.7.10"
    
    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        classpath("com.android.tools.build:gradle:7.3.0")
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version")
        classpath("com.google.gms:google-services:4.3.15")
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Change the root project build directory
rootProject.buildDir = File("../build")

// Change each subproject's build directory to nest under root build
subprojects {
    buildDir = File(rootProject.buildDir, name)
}

// Ensure `:app` is evaluated before others
subprojects {
    evaluationDependsOn(":app")
}

// Register `clean` task to delete the root build directory
tasks.register<Delete>("clean") {
    delete(rootProject.buildDir)
}