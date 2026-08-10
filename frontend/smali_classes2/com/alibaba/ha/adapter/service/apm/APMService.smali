.class public Lcom/alibaba/ha/adapter/service/apm/APMService;
.super Ljava/lang/Object;
.source "APMService.java"


# static fields
.field public static isValid:Z = false


# direct methods
.method public static constructor <clinit>()V
    .locals 1

    :try_start_0
    const-string v0, "com.taobao.monitor.adapter.SimpleApmInitiator"

    .line 19
    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    const/4 v0, 0x1

    sput-boolean v0, Lcom/alibaba/ha/adapter/service/apm/APMService;->isValid:Z
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    const/4 v0, 0x0

    sput-boolean v0, Lcom/alibaba/ha/adapter/service/apm/APMService;->isValid:Z

    :goto_0
    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 13
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static openDebug(Ljava/lang/Boolean;)V
    .locals 1

    sget-boolean v0, Lcom/alibaba/ha/adapter/service/apm/APMService;->isValid:Z

    if-nez v0, :cond_0

    return-void

    .line 34
    :cond_0
    invoke-virtual {p0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p0

    invoke-static {p0}, Lcom/taobao/monitor/adapter/SimpleApmInitiator;->setDebug(Z)V

    return-void
.end method
