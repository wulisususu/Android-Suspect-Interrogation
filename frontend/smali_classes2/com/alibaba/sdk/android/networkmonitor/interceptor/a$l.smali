.class Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$l;
.super Ljava/lang/Object;
.source "InterceptorHelper.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;Ljava/lang/String;ILjava/lang/String;)V
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


# direct methods
.method constructor <init>(Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;Ljava/lang/Object;JLjava/lang/String;ILjava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$l;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;

    iput-object p2, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$l;->a:Ljava/lang/Object;

    iput-wide p3, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$l;->a:J

    iput-object p5, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$l;->a:Ljava/lang/String;

    iput p6, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$l;->a:I

    iput-object p7, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$l;->b:Ljava/lang/String;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$l;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;

    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$l;->a:Ljava/lang/Object;

    .line 1
    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;)Lcom/alibaba/sdk/android/networkmonitor/a;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-wide v1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$l;->a:J

    .line 3
    invoke-virtual {v0, v1, v2}, Lcom/alibaba/sdk/android/networkmonitor/a;->o(J)V

    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$l;->a:Ljava/lang/String;

    .line 4
    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/networkmonitor/a;->g(Ljava/lang/String;)V

    iget v1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$l;->a:I

    .line 5
    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/networkmonitor/a;->a(I)V

    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$l;->b:Ljava/lang/String;

    .line 6
    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/networkmonitor/a;->a(Ljava/lang/String;)V

    .line 8
    new-instance v1, Lcom/alibaba/sdk/android/networkmonitor/n;

    iget-wide v2, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$l;->a:J

    const-string v4, "responseHeadersEnd"

    invoke-direct {v1, v4, v2, v3}, Lcom/alibaba/sdk/android/networkmonitor/n;-><init>(Ljava/lang/String;J)V

    iget-object v2, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$l;->a:Ljava/lang/String;

    .line 9
    invoke-virtual {v1, v2}, Lcom/alibaba/sdk/android/networkmonitor/n;->a(Ljava/lang/String;)V

    iget v2, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$l;->a:I

    .line 10
    invoke-virtual {v1, v2}, Lcom/alibaba/sdk/android/networkmonitor/n;->a(I)V

    .line 11
    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/networkmonitor/a;->a(Lcom/alibaba/sdk/android/networkmonitor/e;)V

    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$l;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;

    .line 13
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "responseHeadersEnd: call = "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v2, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$l;->a:Ljava/lang/Object;

    invoke-virtual {v2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", headers = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$l;->a:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ",code = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$l;->a:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/alibaba/sdk/android/networkmonitor/utils/c;->a(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    return-void
.end method
