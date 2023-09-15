cmake_minimum_required(VERSION 3.16)

project(Persons_Data VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick Core Gui Qml Widgets Sql)

qt_standard_project_setup()

qt_add_executable(Persons_Data MACOSX_BUNDLE
    main.cpp
    icon.rc
)

qt_add_qml_module(Persons_Data
    URI Persons_Data
    VERSION 1.0

    #qml
    QML_FILES
    "Main.qml"
    "qml/OptionsMenu.qml"
    "qml/Models.qml"
    "qml/List_Component.qml"
    "qml/MainView.qml"
    "qml/SaveView.qml"
    "qml/WarningDialog.qml"

    #res
    RESOURCES
    Res.qrc

    #c++
    SOURCES
    database.h
    database.cpp



)

set_target_properties(Persons_Data PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.Persons_Data
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(Persons_Data
    PRIVATE
    Qt6::Quick
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Widgets
    Qt6::Sql
)

include(GNUInstallDirs)
install(TARGETS Persons_Data
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
