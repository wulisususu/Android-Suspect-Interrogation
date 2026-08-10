.class Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$t;
.super Ljava/lang/Object;
.source "InterceptorHelper.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:J

.field final synthetic a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;

.field final synthetic a:Ljava/lang/Object;

.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;Ljava/lang/Object;JLjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$t;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;

    iput-object p2, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$t;->a:Ljava/lang/Object;

    iput-wide p3, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$t;->a:J

    iput-object p5, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$t;->a:Ljava/lang/String;

    iput-object p6, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$t;->b:Ljava/lang/String;

    iput-object p7, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$t;->c:Ljava/lang/String;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$t;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;

    .line 1
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "callStart: call = "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v2, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$t;->a:Ljava/lang/Object;

    invoke-virtual {v2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/alibaba/sdk/android/networkmonitor/utils/c;->a(Ljava/lang/String;Ljava/lang/String;)V

    .line 3
    new-instance v0, Lcom/alibaba/sdk/android/networkmonitor/a;

    invoke-direct {v0}, Lcom/alibaba/sdk/android/networkmonitor/a;-><init>()V

    iget-wide v1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$t;->a:J

    .line 4
    invoke-virtual {v0, v1, v2}, Lcom/alibaba/sdk/android/networkmonitor/a;->f(J)V

    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$t;->a:Ljava/lang/String;

    .line 5
    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/networkmonitor/a;->i(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$t;->b:Ljava/lang/String;

    .line 6
    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/networkmonitor/a;->d(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$t;->c:Ljava/lang/String;

    .line 7
    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/networkmonitor/a;->c(Ljava/lang/String;)V

    .line 8
    new-instance v1, Lcom/alibaba/sdk/android/networkmonitor/e;

    iget-wide v2, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$t;->a:J

    const-string v4, "fetchStart"

    invoke-direct {v1, v4, v2, v3}, Lcom/alibaba/sdk/android/networkmonitor/e;-><init>(Ljava/lang/String;J)V

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/networkmonitor/a;->a(Lcom/alibaba/sdk/android/networkmonitor/e;)V

    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$t;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;

    iget-object v2, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$t;->a:Ljava/lang/Object;

    .line 10
    invoke-virtual {v1, v2, v0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;Lcom/alibaba/sdk/android/networkmonitor/a;)V

    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$t;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;

    .line 12
    invoke-static {v0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;)Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v0

    const/4 v1, 0x0

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 13
    invoke-static {}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Lcom/alibaba/sdk/android/networkmonitor/utils/b;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Landroid/os/Handler;

    move-result-object v0

    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$t;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;

    invoke-static {v1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;)Ljava/lang/Runnable;

    move-result-object v1

    const-wide/32 v2, 0x493e0

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    :cond_0
    return-void
.end method
