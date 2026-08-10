.class Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$h;
.super Ljava/lang/Object;
.source "InterceptorHelper.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->c(Ljava/lang/Object;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:J

.field final synthetic a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;

.field final synthetic a:Ljava/lang/Object;


# direct methods
.method constructor <init>(Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;Ljava/lang/Object;J)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$h;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;

    iput-object p2, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$h;->a:Ljava/lang/Object;

    iput-wide p3, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$h;->a:J

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 7

    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$h;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;

    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$h;->a:Ljava/lang/Object;

    .line 1
    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;)Lcom/alibaba/sdk/android/networkmonitor/a;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 3
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/networkmonitor/a;->b()J

    move-result-wide v1

    iget-wide v3, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$h;->a:J

    .line 4
    invoke-virtual {v0, v3, v4}, Lcom/alibaba/sdk/android/networkmonitor/a;->g(J)V

    .line 5
    new-instance v3, Lcom/alibaba/sdk/android/networkmonitor/d;

    iget-wide v4, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$h;->a:J

    const-string v6, "requestBodyEnd"

    invoke-direct {v3, v6, v4, v5}, Lcom/alibaba/sdk/android/networkmonitor/d;-><init>(Ljava/lang/String;J)V

    .line 6
    invoke-virtual {v3, v1, v2}, Lcom/alibaba/sdk/android/networkmonitor/d;->a(J)V

    .line 7
    invoke-virtual {v0, v3}, Lcom/alibaba/sdk/android/networkmonitor/a;->a(Lcom/alibaba/sdk/android/networkmonitor/e;)V

    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$h;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;

    .line 9
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a()Ljava/lang/String;

    move-result-object v0

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "requestBodyEnd: call = "

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v4, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$h;->a:Ljava/lang/Object;

    invoke-virtual {v4}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", byteCount = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/alibaba/sdk/android/networkmonitor/utils/c;->a(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    return-void
.end method
