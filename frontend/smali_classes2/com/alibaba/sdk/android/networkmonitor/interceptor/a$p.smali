.class Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$p;
.super Ljava/lang/Object;
.source "InterceptorHelper.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;Ljava/lang/Throwable;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:J

.field final synthetic a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;

.field final synthetic a:Ljava/lang/Object;

.field final synthetic a:Ljava/lang/Throwable;


# direct methods
.method constructor <init>(Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;Ljava/lang/Object;JLjava/lang/Throwable;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$p;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;

    iput-object p2, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$p;->a:Ljava/lang/Object;

    iput-wide p3, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$p;->a:J

    iput-object p5, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$p;->a:Ljava/lang/Throwable;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$p;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;

    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$p;->a:Ljava/lang/Object;

    .line 1
    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->b(Ljava/lang/Object;)Lcom/alibaba/sdk/android/networkmonitor/a;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-wide v1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$p;->a:J

    .line 4
    invoke-virtual {v0, v1, v2}, Lcom/alibaba/sdk/android/networkmonitor/a;->a(J)V

    .line 6
    new-instance v1, Lcom/alibaba/sdk/android/networkmonitor/e;

    iget-wide v2, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$p;->a:J

    const-string v4, "callFailed"

    invoke-direct {v1, v4, v2, v3}, Lcom/alibaba/sdk/android/networkmonitor/e;-><init>(Ljava/lang/String;J)V

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/networkmonitor/a;->a(Lcom/alibaba/sdk/android/networkmonitor/e;)V

    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$p;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;

    .line 7
    invoke-virtual {v1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "callFailed: call = "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v3, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$p;->a:Ljava/lang/Object;

    invoke-virtual {v3}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", exception = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$p;->a:Ljava/lang/Throwable;

    invoke-static {v3}, Lcom/alibaba/sdk/android/networkmonitor/a;->a(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/alibaba/sdk/android/networkmonitor/utils/c;->a(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$p;->a:Ljava/lang/Throwable;

    .line 9
    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/networkmonitor/a;->a(Ljava/lang/Throwable;)V

    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$p;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;

    .line 10
    invoke-virtual {v1, v0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Lcom/alibaba/sdk/android/networkmonitor/a;)V

    :cond_0
    return-void
.end method
