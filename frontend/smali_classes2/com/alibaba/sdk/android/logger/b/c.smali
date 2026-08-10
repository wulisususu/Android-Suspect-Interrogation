.class public Lcom/alibaba/sdk/android/logger/b/c;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/alibaba/sdk/android/logger/interceptor/ILogInterceptor;


# instance fields
.field private a:Lcom/alibaba/sdk/android/logger/b/e;


# direct methods
.method public constructor <init>(Lcom/alibaba/sdk/android/logger/b/e;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/alibaba/sdk/android/logger/b/c;->a:Lcom/alibaba/sdk/android/logger/b/e;

    return-void
.end method


# virtual methods
.method public handle(Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;ILcom/alibaba/sdk/android/logger/LogLevel;Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/logger/b/c;->a:Lcom/alibaba/sdk/android/logger/b/e;

    invoke-virtual {v0, p3}, Lcom/alibaba/sdk/android/logger/b/e;->a(Lcom/alibaba/sdk/android/logger/LogLevel;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p1, p2, p3, p4, p5}, Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;->toNextLogInterceptor(ILcom/alibaba/sdk/android/logger/LogLevel;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_0
    return-void
.end method
