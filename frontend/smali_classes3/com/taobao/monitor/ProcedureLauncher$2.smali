.class Lcom/taobao/monitor/ProcedureLauncher$2;
.super Ljava/lang/Object;
.source "ProcedureLauncher.java"

# interfaces
.implements Lcom/taobao/monitor/ProcedureLauncher$Delay;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/monitor/ProcedureLauncher;->initHeader(Landroid/content/Context;Ljava/util/Map;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/taobao/monitor/ProcedureLauncher$Delay<",
        "Ljava/lang/String;",
        ">;"
    }
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 77
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public bridge synthetic call()Ljava/lang/Object;
    .locals 1

    .line 77
    invoke-virtual {p0}, Lcom/taobao/monitor/ProcedureLauncher$2;->call()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public call()Ljava/lang/String;
    .locals 1

    .line 80
    invoke-static {}, Lcom/taobao/monitor/util/ProcessUtils;->getCurrProcessName()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
