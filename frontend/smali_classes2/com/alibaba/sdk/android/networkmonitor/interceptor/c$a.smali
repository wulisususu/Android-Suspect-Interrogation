.class Lcom/alibaba/sdk/android/networkmonitor/interceptor/c$a;
.super Ljava/lang/Object;
.source "OkHttpInterceptorHelper.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;->a(J)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:J

.field final synthetic a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;


# direct methods
.method constructor <init>(Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;J)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/c$a;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    iput-wide p2, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/c$a;->a:J

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/c$a;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;

    .line 1
    new-instance v1, Lcom/alibaba/sdk/android/networkmonitor/c;

    iget-wide v2, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/c$a;->a:J

    const-string v4, "background2forground"

    invoke-direct {v1, v4, v2, v3}, Lcom/alibaba/sdk/android/networkmonitor/c;-><init>(Ljava/lang/String;J)V

    invoke-static {v0, v1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;->a(Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;Lcom/alibaba/sdk/android/networkmonitor/c;)V

    return-void
.end method
