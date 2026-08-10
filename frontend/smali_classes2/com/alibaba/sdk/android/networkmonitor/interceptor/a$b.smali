.class Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$b;
.super Ljava/lang/Object;
.source "InterceptorHelper.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:I

.field final synthetic a:J

.field final synthetic a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;

.field final synthetic a:Ljava/lang/Object;

.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:Ljava/lang/String;

.field final synthetic d:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;Ljava/lang/Object;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;JLjava/lang/String;I)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$b;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;

    iput-object p2, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$b;->a:Ljava/lang/Object;

    iput-object p3, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$b;->a:Ljava/lang/String;

    iput-object p4, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$b;->b:Ljava/lang/String;

    iput-object p5, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$b;->c:Ljava/lang/String;

    iput-wide p6, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$b;->a:J

    iput-object p8, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$b;->d:Ljava/lang/String;

    iput p9, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$b;->a:I

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$b;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;

    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$b;->a:Ljava/lang/Object;

    .line 1
    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;)Lcom/alibaba/sdk/android/networkmonitor/a;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$b;->a:Ljava/lang/String;

    .line 3
    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/networkmonitor/a;->b(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$b;->b:Ljava/lang/String;

    .line 4
    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/networkmonitor/a;->e(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$b;->c:Ljava/lang/String;

    .line 5
    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/networkmonitor/a;->h(Ljava/lang/String;)V

    .line 7
    new-instance v1, Lcom/alibaba/sdk/android/networkmonitor/f;

    iget-wide v2, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$b;->a:J

    invoke-direct {v1, v2, v3}, Lcom/alibaba/sdk/android/networkmonitor/f;-><init>(J)V

    iget-object v2, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$b;->d:Ljava/lang/String;

    .line 8
    invoke-virtual {v1, v2}, Lcom/alibaba/sdk/android/networkmonitor/f;->a(Ljava/lang/String;)V

    iget-object v2, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$b;->a:Ljava/lang/String;

    .line 9
    invoke-virtual {v1, v2}, Lcom/alibaba/sdk/android/networkmonitor/f;->b(Ljava/lang/String;)V

    iget v2, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$b;->a:I

    .line 10
    invoke-virtual {v1, v2}, Lcom/alibaba/sdk/android/networkmonitor/j;->a(I)V

    .line 11
    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/networkmonitor/a;->a(Lcom/alibaba/sdk/android/networkmonitor/e;)V

    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$b;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;

    .line 13
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "connectionAcquired: call = "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v2, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$b;->a:Ljava/lang/Object;

    invoke-virtual {v2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", connectionUrl = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$b;->d:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", destinationIp = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$b;->a:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", protocol = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$b;->b:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", tlsVersion = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$b;->c:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", connection = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$b;->a:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/alibaba/sdk/android/networkmonitor/utils/c;->a(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    return-void
.end method
