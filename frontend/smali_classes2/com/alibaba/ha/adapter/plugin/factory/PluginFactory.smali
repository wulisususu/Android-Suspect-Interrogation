.class public Lcom/alibaba/ha/adapter/plugin/factory/PluginFactory;
.super Ljava/lang/Object;
.source "PluginFactory.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 23
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static createPlugin(Lcom/alibaba/ha/adapter/Plugin;)Lcom/alibaba/ha/protocol/AliHaPlugin;
    .locals 1

    .line 32
    sget-object v0, Lcom/alibaba/ha/adapter/plugin/factory/PluginFactory$1;->$SwitchMap$com$alibaba$ha$adapter$Plugin:[I

    invoke-virtual {p0}, Ljava/lang/Enum;->ordinal()I

    move-result p0

    aget p0, v0, p0

    packed-switch p0, :pswitch_data_0

    const-string p0, "AliHaAdapter"

    const-string v0, "plugin not exist! "

    .line 62
    invoke-static {p0, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    const/4 p0, 0x0

    goto :goto_0

    .line 58
    :pswitch_0
    new-instance p0, Lcom/alibaba/ha/adapter/plugin/OlympicPlugin;

    invoke-direct {p0}, Lcom/alibaba/ha/adapter/plugin/OlympicPlugin;-><init>()V

    goto :goto_0

    .line 54
    :pswitch_1
    new-instance p0, Lcom/alibaba/ha/adapter/plugin/NetworkMonitorPlugin;

    invoke-direct {p0}, Lcom/alibaba/ha/adapter/plugin/NetworkMonitorPlugin;-><init>()V

    goto :goto_0

    .line 50
    :pswitch_2
    new-instance p0, Lcom/alibaba/ha/adapter/plugin/APMPlugin;

    invoke-direct {p0}, Lcom/alibaba/ha/adapter/plugin/APMPlugin;-><init>()V

    goto :goto_0

    .line 46
    :pswitch_3
    new-instance p0, Lcom/alibaba/ha/adapter/plugin/CrashReporterPlugin;

    invoke-direct {p0}, Lcom/alibaba/ha/adapter/plugin/CrashReporterPlugin;-><init>()V

    goto :goto_0

    .line 42
    :pswitch_4
    new-instance p0, Lcom/alibaba/ha/adapter/plugin/WatchPlugin;

    invoke-direct {p0}, Lcom/alibaba/ha/adapter/plugin/WatchPlugin;-><init>()V

    goto :goto_0

    .line 38
    :pswitch_5
    new-instance p0, Lcom/alibaba/ha/adapter/plugin/TLogPlugin;

    invoke-direct {p0}, Lcom/alibaba/ha/adapter/plugin/TLogPlugin;-><init>()V

    goto :goto_0

    .line 34
    :pswitch_6
    new-instance p0, Lcom/alibaba/ha/adapter/plugin/UtPlugin;

    invoke-direct {p0}, Lcom/alibaba/ha/adapter/plugin/UtPlugin;-><init>()V

    :goto_0
    return-object p0

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
