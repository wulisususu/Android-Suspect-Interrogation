.class Lcom/alibaba/sdk/android/networkmonitor/b$a;
.super Ljava/lang/Object;
.source "NetworkMonitorManagerImpl.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/alibaba/sdk/android/networkmonitor/b;->init(Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/alibaba/sdk/android/networkmonitor/b;


# direct methods
.method constructor <init>(Lcom/alibaba/sdk/android/networkmonitor/b;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/networkmonitor/b$a;->a:Lcom/alibaba/sdk/android/networkmonitor/b;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/b$a;->a:Lcom/alibaba/sdk/android/networkmonitor/b;

    .line 1
    invoke-static {v0}, Lcom/alibaba/sdk/android/networkmonitor/b;->a(Lcom/alibaba/sdk/android/networkmonitor/b;)V

    .line 2
    invoke-static {}, Lcom/alibaba/sdk/android/networkmonitor/filter/FilterHandler;->getInstance()Lcom/alibaba/sdk/android/networkmonitor/filter/FilterHandler;

    move-result-object v0

    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/b$a;->a:Lcom/alibaba/sdk/android/networkmonitor/b;

    invoke-static {v1}, Lcom/alibaba/sdk/android/networkmonitor/b;->a(Lcom/alibaba/sdk/android/networkmonitor/b;)Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;

    move-result-object v1

    iget-object v1, v1, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;->a:Ljava/lang/String;

    iget-object v2, p0, Lcom/alibaba/sdk/android/networkmonitor/b$a;->a:Lcom/alibaba/sdk/android/networkmonitor/b;

    invoke-static {v2}, Lcom/alibaba/sdk/android/networkmonitor/b;->a(Lcom/alibaba/sdk/android/networkmonitor/b;)Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;

    move-result-object v2

    iget-object v2, v2, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;->g:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lcom/alibaba/sdk/android/networkmonitor/filter/FilterHandler;->a(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method
