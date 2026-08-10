.class public Lcom/alibaba/sdk/android/logger/interceptor/a;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/alibaba/sdk/android/logger/interceptor/ILogInterceptor;


# instance fields
.field private a:Lcom/alibaba/sdk/android/logger/interceptor/d;


# direct methods
.method public constructor <init>(Lcom/alibaba/sdk/android/logger/interceptor/d;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/alibaba/sdk/android/logger/interceptor/a;->a:Lcom/alibaba/sdk/android/logger/interceptor/d;

    return-void
.end method


# virtual methods
.method public handle(Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;ILcom/alibaba/sdk/android/logger/LogLevel;Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 1

    iget-object p2, p0, Lcom/alibaba/sdk/android/logger/interceptor/a;->a:Lcom/alibaba/sdk/android/logger/interceptor/d;

    new-instance v0, Lcom/alibaba/sdk/android/logger/interceptor/a$1;

    invoke-direct {v0, p0, p1}, Lcom/alibaba/sdk/android/logger/interceptor/a$1;-><init>(Lcom/alibaba/sdk/android/logger/interceptor/a;Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;)V

    invoke-interface {p2, p3, p4, p5, v0}, Lcom/alibaba/sdk/android/logger/interceptor/d;->a(Lcom/alibaba/sdk/android/logger/LogLevel;Ljava/lang/String;[Ljava/lang/Object;Lcom/alibaba/sdk/android/logger/ILogger;)V

    return-void
.end method
