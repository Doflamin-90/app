import 'package:flutter/material.dart';

void main() {
  runApp(const DanggnSearchApp());
}

class DanggnSearchApp extends StatelessWidget {
  const DanggnSearchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '당근마켓 검색 결과',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Pretendard',
      ),
      home: const DanggnSearchResultScreen(),
    );
  }
}

class DanggnSearchResultScreen extends StatelessWidget {
  const DanggnSearchResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 확실히 뜨는 컴퓨터 관련 테스트 이미지 URL들
    final List<Map<String, dynamic>> products = [
      {
        'title': 'AMD 라이젠5 2400G 사무/게이밍 본체',
        'price': '230,000원',
        'location': '경기 성남시 분당구 동내동',
        'time': '7분 전',
        'imageUrl': 'https://images.unsplash.com/photo-1587202372775-e229f172b9d7?w=400',
      },
      {
        'title': 'Intel i5-4590 GTX750Ti 데스크탑 본체',
        'price': '68,000원',
        'location': '경기 성남시 분당구 미금동',
        'time': '3시간 전',
        'imageUrl': 'https://images.unsplash.com/photo-1591799264318-7e6ef8ddb7ea?w=400',
      },
      {
        'title': '인텔 i5-7500, GTX 1060 3G 본체 판매합니다.',
        'price': '250,000원',
        'location': '경기 성남시 분당구 오리동',
        'time': '10분 전',
        'imageUrl': 'https://images.unsplash.com/photo-1547082299-de196ea013d6?w=400',
      },
      {
        'title': 'i7-7700 삼성 게이밍 데스크탑 모니터 세트',
        'price': '420,000원',
        'location': '경기 성남시 분당구 정자동',
        'time': '18분 전',
        'imageUrl': 'https://images.unsplash.com/photo-1525547719571-a2d4ac8945e2?w=400',
      },
      {
        'title': '가성비 게이밍 컴퓨터 본체 팝니다',
        'price': '310,000원',
        'location': '경기 성남시 분당구 분당동',
        'time': '20분 전',
        'imageUrl': 'https://images.unsplash.com/photo-1593640408182-31c70c8268f5?w=400',
      },
      {
        'title': '사무용 인텔 컴퓨터 풀세트 판매',
        'price': '120,000원',
        'location': '경기 성남시 분당구 서현동',
        'time': '25분 전',
        'imageUrl': 'https://images.unsplash.com/photo-1588872657578-7efd1f1555ed?w=400',
      },
      {
        'title': 'RTX 3060 고사양 조립 PC 판매',
        'price': '750,000원',
        'location': '경기 성남시 분당구 판교동',
        'time': '30분 전',
        'imageUrl': 'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?w=400',
      },
      {
        'title': '맥미니 M1 8G 256G 풀박스',
        'price': '480,000원',
        'location': '경기 성남시 분당구 백현동',
        'time': '35분 전',
        'imageUrl': 'https://images.unsplash.com/photo-1611186871348-b1ce696e52c9?w=400',
      },
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. 당근마켓 웹 상단 GNB (Global Navigation Bar)
            Container(
              height: 64,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                children: [
                  // 로고
                  Row(
                    children: const [
                      Icon(Icons.location_on, color: Color(0xFFFF6F0F), size: 26),
                      SizedBox(width: 4),
                      Text(
                        '당근',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFF6F0F),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 30),
                  const Text('중고거래', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  // 웹 검색창
                  Container(
                    width: 280,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F3F6),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: TextEditingController(text: '컴퓨터'),
                            decoration: const InputDecoration(
                              hintText: '물품이나 동네를 검색해보세요',
                              border: InputBorder.none,
                              isDense: true,
                            ),
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                        const Icon(Icons.search, color: Colors.grey, size: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),

            // 2. 검색 타이틀 및 필터 헤더
            Container(
              width: 980,
              padding: const EdgeInsets.only(top: 32, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        '"컴퓨터" 검색 결과',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.my_location, size: 14, color: Colors.black87),
                        label: const Text('현재 위치로 설정', style: TextStyle(fontSize: 12, color: Colors.black87)),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          side: const BorderSide(color: Color(0xFFCCCCCC)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text('중고거래', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            // 3. 4열 그리드 상품 리스트
            SizedBox(
              width: 980,
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // 한 줄에 4개 배치
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 28,
                  childAspectRatio: 0.70, // 비율 유지
                ),
                itemBuilder: (context, index) {
                  final item = products[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 이미지 (네트워크 주소 실패 시 기본 아이콘 대체)
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            item['imageUrl'],
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: const Color(0xFFE9ECEF),
                                child: const Center(
                                  child: Icon(Icons.desktop_windows, size: 48, color: Colors.grey),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // 제목
                      Text(
                        item['title'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 14, color: Color(0xFF212529)),
                      ),
                      const SizedBox(height: 4),
                      // 가격
                      Text(
                        item['price'],
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF212529)),
                      ),
                      const SizedBox(height: 2),
                      // 위치 및 등록 시간
                      Text(
                        '${item['location']} · ${item['time']}',
                        style: const TextStyle(fontSize: 12, color: Color(0xFF868E96)),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}