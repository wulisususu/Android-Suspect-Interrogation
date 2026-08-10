.class Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$k;
.super Ljava/lang/Object;
.source "InterceptorHelper.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;


# direct methods
.method constructor <init>(Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$k;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    const-string v0, "InterceptorHelper"

    const-string v1, "clean up starting"

    .line 1
    invoke-static {v0, v1}, Lcom/alibaba/sdk/android/networkmonitor/utils/c;->a(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$k;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;

    .line 2
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a()V

    .line 3
    invoke-static {}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Lcom/alibaba/sdk/android/networkmonitor/utils/b;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Landroid/os/Handler;

    move-result-object v0

    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$k;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;

    invoke-static {v1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;)Ljava/lang/Runnable;

    move-result-object v1

    const-wide/32 v2, 0x493e0

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method
