.class Lcom/taobao/monitor/adapter/SimpleApmInitiator$5;
.super Ljava/lang/Object;
.source "SimpleApmInitiator.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/monitor/adapter/SimpleApmInitiator;->initFulltrace(Landroid/app/Application;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/taobao/monitor/adapter/SimpleApmInitiator;

.field final synthetic val$application:Landroid/app/Application;


# direct methods
.method constructor <init>(Lcom/taobao/monitor/adapter/SimpleApmInitiator;Landroid/app/Application;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010,
            0x1010
        }
        names = {
            "this$0",
            "val$application"
        }
    .end annotation

    iput-object p1, p0, Lcom/taobao/monitor/adapter/SimpleApmInitiator$5;->this$0:Lcom/taobao/monitor/adapter/SimpleApmInitiator;

    iput-object p2, p0, Lcom/taobao/monitor/adapter/SimpleApmInitiator$5;->val$application:Landroid/app/Application;

    .line 281
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/adapter/SimpleApmInitiator$5;->val$application:Landroid/app/Application;

    .line 285
    invoke-static {v0}, Lcom/ut/device/UTDevice;->getUtdid(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/taobao/monitor/procedure/Header;->utdid:Ljava/lang/String;

    return-void
.end method
